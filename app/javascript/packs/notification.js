function notification () {
  const notificationBtn = document.getElementById("notification-btn");
  notificationBtn.addEventListener('click', () => {
    const XHR = new XMLHttpRequest();
    XHR.open("GET", `/notifications/search_notification`, true);
    XHR.responseType = "json";
    XHR.send();

    XHR.onload = () => {
      const notificationResult = document.getElementById('notification-result');
      notificationResult.innerHTML = "";
      if (XHR.response) {
        const notificationLink = XHR.response.notifications;
        const sendUserNames = XHR.response.send_user_names;

        const deleteElement = document.createElement("div");
        deleteElement.setAttribute("class", "delete-element");
        deleteElement.setAttribute("id", "delete-element");
        deleteElement.innerHTML = "閉じる";
        notificationResult.appendChild(deleteElement);

        if (!notificationLink.length) {
          const childElement = document.createElement("div");
          childElement.setAttribute("class", "notification-child");

          const childA = document.createElement("span");
          childA.innerHTML = '通知はありません';

          childElement.appendChild(childA);
          notificationResult.appendChild(childElement);

          const clickElement = document.getElementById('delete-element');
          clickElement.addEventListener('click', () => {
            childA.remove();
            childElement.remove();
            clickElement.remove();
          });
        }else{
          notificationLink.forEach(function(notification, index) {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "notification-child");
            if (notification.notice) {
              childElement.setAttribute("style", "background-color: #ffffff;");
            }else{
              childElement.setAttribute("style", "background-color: #deffe0;");
            }

            const childA = document.createElement("a");
            childA.setAttribute("href", `/cars/${notification.car_id}`);
            childA.innerHTML = `${sendUserNames[index]}さんが、あなたの投稿にコメントしました`;

            childElement.appendChild(childA);
            notificationResult.appendChild(childElement);

            const clickElement = document.getElementById('delete-element');
            clickElement.addEventListener('click', () => {
              childA.remove();
              childElement.remove();
              clickElement.remove();
            });
          });
        }
      };
    };
  });
};

window.addEventListener('load', notification);