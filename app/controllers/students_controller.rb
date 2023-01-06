class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        render json: Student.all
    end

    def show
        student = find_student
        render json: student, status: :ok
    end

    def create
        new_student = Student.create(student_params)
        render json: new_student, status: :created
    end

    def update
        student = find_student
        student.update(student_params)
        render json: student, status: :accepted
    end

    def destroy
        student = find_student
        student.destroy()
        head :no_content
    end

    private

    def find_student
        Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
    end
end
