class CustomersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      flash[:notice] = 'Customer was successfully created.'
      redirect_to @customer
    else
      render :new
    end
  end

  def edit
  end

  def delete
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :password)
  end
end
