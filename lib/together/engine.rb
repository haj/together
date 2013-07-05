module Together
  class Engine < Rails::Engine
    ActiveSupport.on_load(:action_controller) do
      include Together::ActionControllerExtensions
    end
  end
end
