class Admin::ConfigurablesController < Admin::BaseController
  # include the engine controller actions
  include ConfigurableEngine::ConfigurablesController
end
