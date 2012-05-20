class CaptchaController < ApplicationController
  def show
    render text: session[:captcha]=rand(5).to_s
  end
end
