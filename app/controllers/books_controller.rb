class BooksController < ApplicationController
    before_action :set_book, only: %i[ show edit update destroy ]

    # GET /gestors or /gestors.json
    def index
      if !params[:status].present? 
        @q = Book.all.ransack(params[:q])
        @books = @q.result(distinct: true)
      else
        @q = Book.where("status = ?", params[:status]).ransack(params[:q])
        @books = @q.result(distinct: true).paginate(page: params[:status], per_page: 10)
      end
    end
  
    # GET /gestors/1 or /gestors/1.json
    def show
    end
  
    # GET /gestors/new
    def new
      @book = Book.new
    end
  
    # GET /gestors/1/edit
    def edit
    end
  
    # POST /gestors or /gestors.json
    def create
      @book = Book.new(book_params)
  
      respond_to do |format|
        if @book.save
          format.html { redirect_to book_url(@book), notice: "El libro ha sido creado exitosamente." }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /gestors/1 or /gestors/1.json
    def update
      respond_to do |format|
        if @book.update(book_params)
          format.html { redirect_to book_url(@book), notice: "El libro ha sido actualizado exitosamente." }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /gestors/1 or /gestors/1.json
    def destroy
      @book.destroy
  
      respond_to do |format|
        format.html { redirect_to books_url, notice: "El libro ha sido eliminado exitosamente.." }
        format.json { head :no_content }
      end
    end
  
    private

      #def search_params
      #  default_params = {}
      #  default_params.merge({user_id_eq: current_user.id}) if signed_in?
      #  # more logic here
      #  params[:q].merge(default_params)
      #end

      # Use callbacks to share common setup or constraints between actions.
      def set_book
        @book = Book.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def book_params
        params.require(:book).permit(:title, :author, :status, :loan_date, :return_date)
      end
  end
  