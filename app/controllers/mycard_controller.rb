class MycardController < ApplicationController
  def update
    result = []
    version = params[:version]
    Dir.glob('public/mycard/mycard-update-*-*.zip') do |file|
      if file =~ /mycard-update-(.+?)-(.+?).zip/
        if $1 <= version and $2 > version
          result << "http://card.touhou.cc/mycard/#{$&}"
        end
      end
    end
    respond_to do |format|
      format.json { render json: result }
    end
  end
end