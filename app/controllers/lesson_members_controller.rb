class LessonMembersController < ApplicationController
  include Decomissionable

  def new_lesson_member
    @lesson_member = LessonMember.new
    @lesson_id = params[:lesson_id]

    respond_to do |format|
      format.html { render '_new_lesson_member' }
    end
  end

  def create_lesson_member
    @lesson_member = LessonMember.new(lesson_member_params)
    @lesson_id = params[:lesson_id]

    respond_to do |format|
      if @lesson_member.save
        increment_lesson_members_count
        format.html { redirect_to lesson_url(@lesson_id), notice: "Student added to lesson." }
        format.json { render :show, status: :created, location: @lesson_member }
      else
        format.html { render '_new_lesson_member', status: :unprocessable_entity }
        format.json { render json: @lesson_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_lesson_member
    @lesson_member = LessonMember.find_by({
      lesson_id: params[:lesson_id],
      student_id: params[:student_id],
    })
    decomission_old_version(@lesson_member, decomission_timestamp: Time.now)
    decrement_lesson_members_count

    respond_to do |format|
      format.html { redirect_to lesson_url(@lesson_member.lesson_id), notice: "Student removed from lesson." }
      format.json { head :no_content }
    end
  end

  private

    def increment_lesson_members_count
      lesson = Lesson.find(@lesson_id)
      lesson.lesson_members_count += 1
      lesson.save
    end

    def decrement_lesson_members_count
      lesson = Lesson.find(@lesson_member.lesson_id)
      lesson.lesson_members_count -= 1
      lesson.save
    end

    def lesson_member_params
      params.require(:lesson_member).permit(:lesson_id, :student_id)
    end
end
