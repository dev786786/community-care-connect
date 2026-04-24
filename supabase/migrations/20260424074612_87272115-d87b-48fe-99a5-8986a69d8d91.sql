-- 1. Add coins column to profiles
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS coins integer NOT NULL DEFAULT 0;

-- 2. Trigger function: award 100 coins to referrer on new referral row
CREATE OR REPLACE FUNCTION public.award_referral_coins()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO 'public'
AS $$
BEGIN
  -- Unique constraint on referred_user_id (added below) guarantees one reward per referred user
  UPDATE public.profiles
  SET coins = coins + 100,
      updated_at = now()
  WHERE user_id = NEW.referrer_id;
  RETURN NEW;
END;
$$;

-- 3. Ensure one referral per referred user (prevents double rewards)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'referrals_referred_user_id_key'
  ) THEN
    ALTER TABLE public.referrals
      ADD CONSTRAINT referrals_referred_user_id_key UNIQUE (referred_user_id);
  END IF;
END$$;

-- 4. Create trigger on referrals insert
DROP TRIGGER IF EXISTS trg_award_referral_coins ON public.referrals;
CREATE TRIGGER trg_award_referral_coins
AFTER INSERT ON public.referrals
FOR EACH ROW
EXECUTE FUNCTION public.award_referral_coins();