#encoding: UTF-8
class RoomsController < ApplicationController
  User_Filter = /\[(\d+),(.+?),(-1|0)\]/
  Room_Filter = /\[(\d+),(.+?),(wait|start)(#{User_Filter}+?)\]/
  require 'open-uri'
  layout 'losses'
  def index
    @rooms = []
    @actions = ["在线大厅"]
    respond_to do |format|
      format.html # index.html.erb
      format.json  do
        open('http://140.113.242.66:7922/?operation=getroom') do |file|
          file.set_encoding("GBK")
          file.read.encode("UTF-8").scan(Room_Filter) do |id, name, status, users|
            room = {id: id.to_i, name: name, status: status}
            room[:users] = []
            users.scan(User_Filter) do |player, name, certified|
              if certified=="-1"
                user = User.find_by_name(name)
                user = {player: player.to_i, id: user ? user.id : 0, name: name, certified: true}
              else
                user = {player: player.to_i, id: 0, name: name, certified: certified=="-1"}
              end
              room[:users] << user
            end
            @rooms << room
          end
        end
        render json: @rooms
      end
    end
  end
end
