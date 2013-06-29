module Together
  module ActionControllerExtensions
    extend ActiveSupport::Concern

    included do
      helper_method :current_tenant
    end
    
    # Get current tenant, overwrite this in a controller to use different strategy
    def current_tenant
      Tenant.find_by_domain! current_user.email_domain
    end
  end
end