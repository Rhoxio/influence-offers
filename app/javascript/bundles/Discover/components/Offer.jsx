import PropTypes from 'prop-types';
import React, { useState } from 'react';

const Offer = ({offer, tags, show, setError}) =>{
  // console.log(tags)
  const unclaimedButtonData = {text: "Claim", disabled: false, claimed: false}
  const claimedButtonData = {text: "Claimed!", disabled: true, claimed: true}
  const pendingButtonData = {text: "Claiming...", disabled: true, claimed: false}
  const [buttonState, setButtonState] = useState(unclaimedButtonData)

  const claimClickHandler = (event) => {
    event.preventDefault()
    const response = postClaimOffer()
    response.then((res) => (
      handleClaimResponse(res)
    ))
  }

  const delegateButtonState = (stateToSet) => {
    const buttonStates = {
      "claimed": claimedButtonData,
      "pending": pendingButtonData,
      "unclaimed": unclaimedButtonData
    }
    setButtonState(buttonStates[stateToSet])
  }

  const handleClaimResponse = (res) =>{
    if(res.status){
      switch(res.status){
        case '409':
          setError('You have already claimed this offer.')
          delegateButtonState("claimed")
          break;
        case '401':
          setError('Sign in again to continue.')
          delegateButtonState("unclaimed")
          break;
        case '403':
          setError('An error has occured. Refresh the page and try again.')
          delegateButtonState("unclaimed")
          break;
        default:
          setError(res.message)
      }
    } else {
      delegateButtonState("claimed")
      return res
    }
  }

  const postClaimOffer = async (event) =>{
    const location = `${window.location.protocol}//${window.location.host}`
    const url = `${location}/api/v1/offers/${offer.id}/claim`
    const csrf = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
    const body = {
      method: "POST",
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrf,
      }
    }
    try {
      delegateButtonState("pending")
      const response = await fetch(url, body)
      const data = await response.json();
      return data
    } catch (error) {
      return error
    }
  }

  if(show){
    return(
      <div className="offer">
        <h5 className="offer-title">{offer.title}</h5>
        <p className="offer-description">{offer.description}</p>
        <div className="tag-container">
          {tags.map((tag, index) => (
            <span key={tag.slug} className="tag">{tag.name}</span> 
          ))}      
        </div>
        <hr/>
        <button 
          data-offer-id={offer.id} 
          onClick={claimClickHandler} 
          className="claim-button"
          disabled={buttonState.disabled}
        >
          {buttonState.text}
        </button>

      </div>
    )    
  }


}

export default Offer;