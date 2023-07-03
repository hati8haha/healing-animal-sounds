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


modelViewer.addEventListener('click', function () {
  modelViewer.animationName = randomAction()
  setTimeout(function () {
    modelViewer.animationName = defaultAction
  }, 2000)
})
