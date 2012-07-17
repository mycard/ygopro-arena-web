#encoding: UTF-8
class RoomsController < ApplicationController
  require 'open-uri'
  layout false
  def index
    @rooms = []
    @actions = ["在线大厅"]
    @server = params[:server_id] ? Server.find(params[:server_id]) : Server.where(server_type: "ygopro").first
    @server.cache = JSON.parse @server.cache rescue nil
    respond_to do |format|
      format.html # index.html.erb
      format.json  do
        if @server.cached_at and Time.now - @server.cached_at <= 3
          room_json = @server.cache
        else
          open("#{@server.index}/?operation=getroomjsondelphi") do |file|
            @rooms = JSON.parse(file.read)["rooms"].collect do |r|
              room = {id: r["roomid"].to_i, name: decode(r["roomname"]), status: r["istart"].to_sym, player1: nil, player2: nil, private: r["needpass"]=="true"}
              r["users"].each do |u|
                name = decode(u["name"])
                if u["id"] == "0"
                  user = {player: u["pos"].to_i%2 == 0, id: 0, name: name, certified: false}
                else
                  user = User.find_by_name(name)
                  user = {player: u["pos"].to_i%2 == 0, id: user ? user.id : 0, name: name, certified: true}
                end
                if user[:player]
                  room[:player1] = user
                else
                  room[:player2] = user
                end
              end
              room
            end
            room_json = @rooms.to_json
            @server.update_attributes(cache: room_json, cached_at: Time.now)
          end
        end
        render json: room_json
      end
    end
  end

  private
  def decode(str)
    [str].pack('H*').force_encoding("UTF-16BE").encode("UTF-8", :undef => :replace, :invalid => :replace)
  end
end
