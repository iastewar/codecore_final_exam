$(function() {
  $("#new_bid").on("submit", function() {
    var postData = $(this).serializeArray();
    var formURL = $(this).attr("action");
    $.ajax(
    {
        url : formURL,
        type: "POST",
        data : postData,
        dataType: "json",
        success: function(data, textStatus, xhr) {
          if (data.price) {
            $("#bids").prepend("<div class='well' style='display: none' id=" + data.price + ">$" +
              data.price.toFixed(2) +
              "<div class='pull-right owned'>" +
              data.name +
              "</div>" +
            "</div>");

            $("#" + data.price).fadeIn();

            $("#current_price").html((parseInt($("#current_price").html()) + 1).toFixed(2));
            if (parseInt($("#winning_price").html()) < data.price)
              $("#winning_price").html(data.price.toFixed(2));
          } else {

          }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log("failed to send the bid request");
        }
    });

    event.preventDefault();
  })

  $(document).on("click", ".clickable_html", function() {
    event.stopPropagation();
    var link = $(this).find("a").attr("href");
    window.location = link;
  })

})
