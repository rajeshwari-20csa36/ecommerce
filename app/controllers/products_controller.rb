class ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :set_category
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = if @category.present?
                  @category.products.all
                else
                  @from_date = (params[:from_date]&.to_date || Date.yesterday)
                  @to_date = (params[:to_date]&.to_date || Date.today)
                  Product.all.date_between(@from_date.at_beginning_of_day, @to_date.at_end_of_day).includes(:category)
                end
    @products = @products.paginate(page: params[:page])
  end

  # GET /products/1 or /products/1.json
  def show
    default_ratings = Hash[(1..5).reverse_each.map { |n| [n, 0] }]
    @ratings = default_ratings.merge @product.ratings.group(:star).count
    @comment = Comment.new
    @comments = @product.comments
  end

  # GET /products/new
  def new
    @product = @category.products.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = @category.products.new(product_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @product.save
        format.html { redirect_to category_product_url(@category, @product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to category_product_url(@category, @product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to category_products_url(@category), notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def read
    @product.users << current_user unless @product.users.include?(current_user)
    head :created
  end

  private
    def set_category
      @category = Category.find(params[:category_id]) if params[:category_id].present?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = @category.products.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :category_id)
    end
end
