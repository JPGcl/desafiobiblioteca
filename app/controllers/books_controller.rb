class BooksController < ApplicationController
    before_action :set_book, only: %i[ show edit update destroy ]
  
    # GET /gestors or /gestors.json
    def index
      puts params[:search]
      if !params[:search].present? || params[:search] == "*" 
        @books = Book.all
      else
        @books = Book.where("status = ?",params[:search])
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
      # Use callbacks to share common setup or constraints between actions.
      def set_book
        @book = Book.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def book_params
        params.require(:book).permit(:title, :author, :status, :loan_date, :return_date)
      end
  end
  