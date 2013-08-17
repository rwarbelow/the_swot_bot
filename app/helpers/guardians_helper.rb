module GuardiansHelper
  def require_guardians
    redirect_to error_url unless current_user && current_user.guardian_profile_id != nil
  end
end
