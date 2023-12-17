import PropTypes from 'prop-types';
import React, { useState, useContext } from 'react';

const ErrorDisplay = ({error, setError}) => {  
  let styles = {display: 'none'}
  
  if(error.length > 0){
    styles = {}
  }

  const closeError = (event) =>{
    event.preventDefault()
    setError("")
  }

  return(
    <div 
      className="react-errors-container"
      style={styles}
      onClick={closeError}
    >
      <span className="message">{error}</span>
      <br/>
      <span className="close-me">Tap to Close</span>
    </div>
  )
}

export default ErrorDisplay;