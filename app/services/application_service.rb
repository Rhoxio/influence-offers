# Base with added functionality for more functional style and the ability to forego class instantiation.
class ApplicationService
  # Used as the defaut case when ApplicationService is used in other code. Provides a flexible interface with block. 
  def self.call(*args, &block)
    new(*args, &block).call
  end
end