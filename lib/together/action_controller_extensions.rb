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

    # Use this method in an around filter to set correct schema
    def scope_current_tenant &block
      if current_user
        current_user.create_tenant # make sure there is a tenant
        
        current_tenant.scope_schema &block
      else
        yield
      end
    end
  end
end