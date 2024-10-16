require "rails_helper"
RSpec.describe CustomersController, type: :controller do
    let(:customer) { 
      Customer.create(name: "alice", email: "alice@gmail.com", password: "12345")
    } 
    describe "** GET #index" do
      subject do
        get :index
      end

      it "returns success 200 (OK)" do
        get :index
        expect(response).to have_http_status(200) 
      end
      
      it "renders the application layout" do
        expect(subject).to render_template("layouts/application")
      end

      it "renders the index template" do
        expect(subject).to render_template(:index)
        expect(subject).to render_template("index")
        expect(subject).to render_template("customers/index")
      end

      it "does not render a different template" do
        expect(subject).to_not render_template("customers/show")
      end
    end

    describe "** GET #show" do
      subject { 
        get :show, params: { id: customer.id }
      }

      it "renders the show template" do
        expect(subject).to render_template(:show)
        expect(subject).to render_template("show")
        expect(subject).to render_template("customers/show")
      end
    end

    describe "** GET #new" do
      subject { get :new } 

      it "renders the new template" do
        expect(subject).to render_template(:new)
      end
    end


    describe "** POST #create" do
      let(:valid_attributes) {
        { customer: { 
            name: "New Customer",
            email: "new_customer@example.com",
            password: "0987654321"
        } }
      }
      context "with valid parameters" do

        subject { post :create, params: valid_attributes } 

        it "creates a new Customer" do
          expect{ post :create, params: valid_attributes }.to change(Customer, :count).by(1)
        end

        it "redirects_to(@customer)" do
          # assigns is an RSpec method that allows you to access controller instance
          # variables in your test
          expect(subject).to redirect_to(assigns(:customer))
        end

        it "redirects_to customer_url(@customer)" do
          expect(subject).to redirect_to(customer_url(assigns(:customer)))
        end

        it "redirects_to /customer/:id" do
          expect(subject).to redirect_to("/customers/#{assigns(:customer).id}")
        end
      end
    end

    describe "** Numeric Status Code" do
      controller do
        def index
          render json: {}, status: 209
        end
        def destroy
          render json: {}, status: :bad_gateway
        end
      end
      it "returns a 209 custom status code" do
        get :index
        expect(response).to have_http_status(209)
      end
      it "returns a bad_gateway generic status type" do
        delete :destroy, params: { id: customer.id }
        expect(response).to have_http_status(:bad_gateway)
      end
    end

    describe "** Cookies" do
      controller do
        def clear_cookie
          cookies.delete(:user_name)
          head :ok
        end
      end
    
      before do
        routes.draw { get "clear_cookie", to: "customers#clear_cookie" }
      end
    
      it "clear cookie's value 'user_name'" do
        cookies[:user_name] = "Sam"
    
        get :clear_cookie
    
        expect(cookies[:user_name]).to eq nil
      end
    end
    
    
end
