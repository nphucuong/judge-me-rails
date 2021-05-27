class HardWorker
  include Sidekiq::Worker

  def perform()
    puts('Working hard')
  end
end
