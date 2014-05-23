class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end

class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
end

class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end
