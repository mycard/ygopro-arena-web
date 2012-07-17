class StreamController < ApplicationController
  respond_to :html, :json
  def index
    @posts = Post.group(:topic_id).limit(10).order(:id).reverse_order.includes(:user).includes(:topic=>[:board])
    @posts = @posts.where('created_at > ?', params[:time]) if params[:time]
    @topics = @posts.collect{|post|post.topic}
    @posts = @posts.to_a
    @topics.each{|topic|post = topic.posts.order(:id).last; @posts << post unless @posts.include? post}
    @boards = @topics.collect{|topic|topic.board}.uniq
    @users = @posts.collect{|post|post.user}.uniq
    respond_to do |format|
      format.json { render json: {posts: @posts, topics: @topics, boards: @boards, users: @users} }
    end
  end
end
