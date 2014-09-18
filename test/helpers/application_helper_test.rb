require 'test_helper'

describe ApplicationHelper do
  include ERB::Util

  describe 'draw_icon' do
    it 'render proper html' do
      draw_icon('name').
          must_equal '<i class="icon-name" title=""></i>'

      draw_icon('name', class: 'some-class', title: 'Some title >').
          must_equal '<i class="icon-name some-class" title="Some title &gt;"></i>'
    end

    it 'render proper html for frontend' do
      def draw_frontend_icon(icon, opts = {})
        "frontend-icon-#{icon}"
      end
      def controller.controller_path
        'welcome'
      end

      draw_icon('name').
          must_equal 'frontend-icon-name'
    end

    it 'render proper html for backend' do
      def draw_backend_icon(icon, opts = {})
        "backend-icon-#{icon}"
      end
      def controller.controller_path
        'admin/welcome'
      end

      draw_icon('name').
          must_equal 'backend-icon-name'
    end
  end

  describe 'print_check_mark' do
    it 'render proper html' do
      print_check_mark(true).
          must_equal '<i class="icon-check" title=""></i>'

      print_check_mark(false).
          must_equal '<i class="icon-check-empty" title=""></i>'
    end
  end

  describe 'remove_icon' do
    it 'render proper html' do
      remove_icon.
          must_equal '<i class="icon-remove" title=""></i>'
    end
  end
end
