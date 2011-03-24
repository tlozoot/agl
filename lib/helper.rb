# coding: utf-8
class Helper
  include Singleton
  include ApplicationHelper
end

def help
  Helper.instance
end