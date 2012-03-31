class MycardController < ApplicationController
  def update
    result = []
    version = params[:version]
    loop do
      new_version = false
      Dir.glob('public/mycard/mycard-update-*-*.zip') do |file|
        if file =~ /mycard-update-(.+?)-(.+?).zip/
          if $1 <= version and $2 > version
            version = $2
            result << "http://card.touhou.cc/mycard/#{$&}"
            new_version = true
            break
          end
        end
      end
      if !new_version
        break
      end
    end
    respond_to do |format|
      format.json { render json: result }
    end
  end
  def download
    file = Dir.glob('public/mycard/mycard-*-win32.7z').max
    if file
      file = File.basename(file)
      respond_to do |format|
        format.html {redirect_to "/mycard/#{file}" }
      end
    end
  end
end