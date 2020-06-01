
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

// Now that you are connected, you can join channels with a topic:
const createSocket = (topicId) => {
let channel = socket.channel(`comments:${topicId}`, {})
channel.join()
  .receive("ok", resp => {
    renderComments(resp.comments)
  })
  .receive("error", resp => { console.log("Unable to join", resp) })


  channel.on(`comments:${topicId}:new`, renderSingleComment)

  document.querySelector("button").addEventListener('click', () => {
    const content = document.querySelector("textarea").value
    channel.push("comment:add", {content: content})
  })
}

function renderComments(comments){
  const renderedComments = comments.map(c => {
    return `<li class="collection-item" >${c.content}</li>`
  })
  document.querySelector('.collection').innerHTML = renderedComments.join('')
}

function renderSingleComment(event){
      return   document.querySelector('.collection').innerHTML += `<li class="collection-item" >${event.comment.content}</li>`
}


window.createSocket = createSocket;
