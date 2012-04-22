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
        Server.all.each_with_index do |server, index|
          open("http://#{server.ip}:#{server.http_port}/?operation=getroomjson", 'r:GBK') do |file|
            JSON.parse(file.read.encode("UTF-8"))["rooms"].each do |r|
              room = {id: ('A'.ord+index).chr + r["roomid"], name: r["roomname"], status: r["istart"].to_sym, users: []}
              r["users"].each do |u| 
                if u["id"] == "0"
                  user = {player: u["pos"].to_i%2+1, id: 0, name: u["name"], certified: false}
                else
                  user = User.find_by_name(u["name"])
                  user = {player: u["pos"].to_i%2+1, id: user ? user.id : 0, name: u["name"], certified: true}
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
end
