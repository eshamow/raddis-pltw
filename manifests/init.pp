class pltw (
  $message = 'pltw',
) {

  notify { 'pltw':
    message => $message,
  }

}
