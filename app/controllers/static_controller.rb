require 'mail'

class StaticController < ApplicationController
  def home
    @error = false
  end

  def help
    @error = false
    unless not params[:phone].first.blank? or not params[:email].first.blank?
      @error = true
    else
      calculated_body = "El #{DateTime.now.in_time_zone("Caracas").strftime('%d/%m/%Y a las %I:%M%p')} se recibió una solicitud de información:\n\n"
      calculated_body << "#{params[:message]}\n\n"
      calculated_body << "Contestar a: \n"
      if not params[:phone].first.blank?
        calculated_body << "Telefono - #{params[:phone][0]}\n"
      end
      if not params[:email].first.blank?
        calculated_body << "Email - #{params[:email][0]}\n"
      end

      send = get_send
      recv = get_recv
      p = get_p

      Mail.defaults do
        options = {
            :address              => "smtp.gmail.com",
            :port                 => 587,
            :user_name            => send,
            :password             => p,
            :authentication       => 'plain',
            :enable_starttls_auto => true
        }
        delivery_method :smtp, options
      end

      Mail.deliver do
             to recv
           from (send + '@gmail.com')
        subject 'Solicitud de información en la página web'
           body calculated_body
      end
    end
    render :home
  end

  private

  def get_send()
    sql = "SELECT info_send FROM SINGLETON_INFOS"
    ActiveRecord::Base.connection.execute(sql).getvalue(0,0)
  end

  def get_recv()
    sql = "SELECT info_recv FROM SINGLETON_INFOS"
    ActiveRecord::Base.connection.execute(sql).getvalue(0,0)
  end

  def get_p()
    sql = "SELECT info_p FROM SINGLETON_INFOS"
    ActiveRecord::Base.connection.execute(sql).getvalue(0,0)
  end
end
