class NotifyWorker
    include Sidekiq::Worker
    def perform(params)
      @params = params
      yo=PrivatePub
      yo.load_config('config/private_pub.yml', Rails.env) 
      yo.publish_to "/messages/#{@params.queue}", :chat_message => @params.message
    end
end
