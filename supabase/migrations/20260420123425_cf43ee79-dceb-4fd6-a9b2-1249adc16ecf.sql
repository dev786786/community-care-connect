CREATE OR REPLACE FUNCTION public.get_accepted_donor_contact(_request_id uuid)
RETURNS TABLE (
  donor_user_id uuid,
  display_name text,
  phone text,
  email text
)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public
AS $$
  SELECT
    p.user_id AS donor_user_id,
    p.display_name,
    p.phone,
    p.emergency_contact_email AS email
  FROM public.donor_contact_requests c
  JOIN public.profiles p ON p.user_id = c.donor_user_id
  WHERE c.request_id = _request_id
    AND c.requester_id = auth.uid()
    AND c.status = 'accepted';
$$;