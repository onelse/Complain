class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:main]
  before_action :hash_tag
  load_and_authorize_resource

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @posts = Post.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    
  end
  
  def main
    authorize! :main, @post
  end
  

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

# 공감
def upvote
    @post = Post.find(params[:id])
  if ((current_user.voted_up_on? @post) == true)
        @post.unliked_by current_user
        redirect_to(request.referrer, :notice => '공감취소했습니다')
    else
        @post.upvote_by current_user
        redirect_to(request.referrer, :notice => '공감했습니다')
  end
end

# 비공감
def downvote
    @post = Post.find(params[:id])
    if ((current_user.voted_down_on? @post) == true)
        @post.unliked_by current_user    
        redirect_to(request.referrer, :notice => '비공감취소했습니다')
    else
        @post.downvote_from current_user
        redirect_to(request.referrer, :notice => '비공감했습니다')
    end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
    
    # def check_page
      
    # end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :hashtag, :user_id)
    end
    
    
    # 해시태그 랜덤 뽑기
    def hash_tag
      
      @hash_1 = Array.new # 배열을 하나 새로 만든다.
      hash = Post.all.order("RANDOM()").first(1) # 최신 포스트를 모두 가져온 다음
      hash.each do |h| # each로 하나씩 x로
        @hash_1.push(h) # notice_1에서 x를 push하면
        break;
      end  
    end  
    



    
    
    
end
