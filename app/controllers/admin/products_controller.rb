class Admin::ProductsController < Admin::BaseController

    def index
    @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10)
     .order("id desc")
    end


    def new
    end

    def create
    end

    def edit
    end

    def update

    end

    def destroy 

    end

end
