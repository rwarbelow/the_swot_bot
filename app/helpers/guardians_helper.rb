module GuardiansHelper
  def require_guardian
    redirect_to error_url unless current_user.session_user_type == :GuardianProfile
  end
end
