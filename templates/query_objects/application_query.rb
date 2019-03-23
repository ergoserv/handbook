class ApplicationQuery
  attr_reader :relation

  def initialize(relation = nil)
    @relation = relation || default_relation
  end

  def query
    raise NotImplementedError
  end

  def call(*args)
    query(*args)
  end

  def self.call(*args)
    new.call(*args)
  end

  protected

  def default_relation
    raise NotImplementedError
  end
end
