class Admin::ProductsController < Admin::BaseController

    before_action :find_product, only: [:edit, :update, :destroy]

    def index
        @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10)
         .order("id desc")
    end


    def new
        @product = Product.new
        @root_categories = Category.roots
    end

    def create
        @product = Product.new(params.require(:product).permit!)
        @root_categories = Category.roots
    
        if @product.save
          flash[:notice] = "Saved Successfully"
          redirect_to admin_products_path
        else
          render action: :new
        end
    end

    def edit
        @root_categories = Category.roots
        render action: :new
    end

    def update
        @product.attributes = params.require(:product).permit!
        @root_categories = Category.roots
        if @product.save
          flash[:notice] = "Update finshed"
          redirect_to admin_products_path
        else
          render action: :new
        end
    end

    def destroy 
        if @product.destroy
        flash[:notice] = "Deletion Successes"
        redirect_to admin_products_path
      else
        flash[:notice] = "Fail to delete"
        redirect_back fallback_location: root_path
      end
    end

    private
    def find_product
      @product = Product.find(params[:id])
    end

end
