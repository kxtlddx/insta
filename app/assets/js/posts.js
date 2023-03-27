


function addHeartEventListeners() {
    const hearts = document.querySelectorAll('.heart');
    hearts.forEach(heart => {
        if (!heart.hasListener) {
            heart.addEventListener('click', () => {
                heart.classList.toggle('fill-color');
            });
            heart.hasListener = true;
        }
    });
}


function isElementInViewport(el) {
    const rect = el.getBoundingClientRect();

    return (
        rect.top >= 0 &&
        rect.left >= 0 &&
        rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
        rect.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
}

let currentOffset = 0;
const postsPerPage = 4;

window.addEventListener('scroll', () => {
    const posts = document.querySelectorAll('#posts-container p');
    const thirdToLastPost = posts[posts.length - 2];
    if (isElementInViewport(thirdToLastPost)) {
        currentOffset += postsPerPage;
        $.getScript($('.load-more-posts').attr('href') + '?offset=' + currentOffset);
        addHeartEventListeners()
    }
});


addHeartEventListeners()

function likePost(postId, userId) {
    const data = { like: { post_id: postId, user_id: userId } };
    const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    fetch('/likes', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': token,
            'Accept': 'application/json'
        },
        body: JSON.stringify(data),
        credentials: 'same-origin'
    }).then(response => response.json())
        .then(data => {
            document.querySelector(`#like-count-${postId + 1}`).textContent = data.like_count;
        });
}