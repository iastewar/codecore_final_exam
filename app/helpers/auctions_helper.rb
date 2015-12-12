module AuctionsHelper
  def label_class(state)
    case state
    when "published"
      "label-default"
    when "reserved_met"
      "label-primary"
    when "won"
      "label-success"
    when "cancelled"
      "label-danger"
    when "reserved_not_met"
      "label-warning"
    end
  end
end
