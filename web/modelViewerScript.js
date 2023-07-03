const modelViewer = document.querySelector('model-viewer')
const defaultAction = 'Idle_A'
const actions = [ 
  'Attack',
  'Bounce',
  'Clicked',
  'Death',
  'Eat',
  'Fear',
  'Fly',
  'Hit',
  'Idle_B',
  'Idle_C',
  'Jump',
  'Roll',
  'Run',
  'Sit',
  'Spin',
  'Swim',
  'Walk'
]

function randomAction () {
  return actions[Math.round(Math.random() * (actions.length - 1))]
}

var setTimeout

modelViewer.addEventListener('click', function () {
  clearTimeout(setTimeout)
  modelViewer.animationName = randomAction()
  setTimeout = setTimeout(function () {
    modelViewer.animationName = defaultAction
  }, 2000)
})
