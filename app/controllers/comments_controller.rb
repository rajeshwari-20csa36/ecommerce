class CommentsController < ApplicationController
  before_action :set_category_product
  before_action :set_comment, only: %i[ edit update destroy ]
  # before_action :set_comments, only: %i[ create update]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = @product.comments.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = @product.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        @comments = @product.comments
        format.html { redirect_to category_product_path(@category, @product), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
        format.js
      else
        format.html { render :'products/show', status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update

    respond_to do |format|
      if @comment.update(comment_params)
        @comments = @product.comments
        format.html { redirect_to category_product_path(@category, @product), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
        format.js
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to category_product_path(@category, @product), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = @product.comments.find(params[:id])
  end

  def set_comments
    @comments = @product.comments
  end

  def set_category_product
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:product_id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:description)
  end
end
