#encoding: UTF-8
class RoomsController < ApplicationController
  require 'open-uri'
  layout 'losses'
  def index
    @rooms = []
    @actions = ["在线大厅"]
    respond_to do |format|
      format.html # index.html.erb
      format.json  do
        if params[:server_id]
          servers = Server.where(id: params[:server_id])
        else
          servers = Server.where(server_type: "ygopro")
        end
        servers.each_with_index do |server, index|
          open("#{server.index}/?operation=getroomjsondelphi") do |file|
            JSON.parse(file.read)["rooms"].each do |r|
              room = {id: ('A'.ord+index).chr + r["roomid"], name: decode(r["roomname"]), status: r["istart"].to_sym, users: []}
              r["users"].each do |u| 
                if u["id"] == "0"
                  user = {player: u["pos"].to_i%2+1, id: 0, name: decode(u["name"]), certified: false}
                else
                  user = User.find_by_name(u["name"])
                  user = {player: u["pos"].to_i%2+1, id: user ? user.id : 0, name: decode(u["name"]), certified: true}
                end
                room[:users] << user
              end
              @rooms << room
            end
          end
        end
        render json: @rooms
      end
    end
  end

  private
  def decode(str)
    [str].pack('H*').force_encoding("UTF-16BE").encode("UTF-8", :undef => :replace, :invalid => :replace)
  end
end
