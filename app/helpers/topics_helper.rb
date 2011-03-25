module TopicsHelper
  def control_topic_path(topic, data_control)
    "/topic/control?id=#{topic.is_a?(Topic) ? topic.id : topic.collect{|t|t.id}.join(',')}&#{data_control.collect{|key, value|"#{key}=#{value}"}.join('&')}"
  end
end
