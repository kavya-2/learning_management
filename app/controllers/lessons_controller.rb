class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[ show update ]

  def show
    @course = @lesson.course
  end

  def update
    @lesson_user = LessonUser.find_or_create_by(user: current_user, lesson: @lesson)
    @lesson_user.update!(completed: true)
    next_lesson = @course.lessons.where("position > ?", @lesson.position).order(:position).first
    if next_lesson
      redirect_to course_lesson_path(@course, next_lesson)
    else
      redirect_to course_path(@course), notice: "You've completed the course"
    end
  end

  private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end
end
