import PropTypes from 'prop-types';
import React, { useState, useContext } from 'react';
import { DiscoverContext } from './DiscoverContext'

const Offer = ({offer, tags, show, setError, suggestionMetrics}) =>{
  const offersData = useContext(DiscoverContext)
  const actionSet = offersData.actionSet

  const unclaimedButtonData = {text: "Claim", disabled: false }
  const claimedButtonData = {text: "Claimed!", disabled: true}
  const pendingButtonData = {text: "Claiming...", disabled: true }

  const deleteButtonData = {text: "Unclaim", disabled: false }
  const deleteButtonPendingData = {text: "Unclaiming...", disabled: true }
  const deleteButtonDoneData = {text: "Unclaimed!", disabled: true }

  const [buttonState, setButtonState] = useState(unclaimedButtonData)
  const [deleteButtonState, setDeleteButtonState] = useState(deleteButtonData)

  // Log Util
  const logSuggestionData = () =>{
    if(suggestionMetrics.total_weight > 0){
      console.info(`Suggestion Weight Data for: ${suggestionMetrics.title}`)
      console.log({...suggestionMetrics, offer: offer})      
    }
  }

  // CLAIM
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
        case 409:
          setError('You have already claimed this offer.')
          delegateButtonState("claimed")
          break;
        case 401:
          setError('Sign in again to continue.')
          delegateButtonState("unclaimed")
          break;
        case 403:
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
      setError(error.message)
      return error
    }
  }  

  // UNCLAIM
  const deleteClickHandler = (event) =>{
    event.preventDefault()
    const response = deleteClaimOffer()
    response.then((res) => (
      handleDeleteClaimResponse(res)
    ))    
  }

  const deleteClaimOffer = async (event) =>{
    const location = `${window.location.protocol}//${window.location.host}`
    const url = `${location}/api/v1/offers/${offer.id}/unclaim`
    const csrf = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
    const body = {
      method: "DELETE",
      headers: {
        'X-CSRF-Token': csrf
      }
    }
    try{
      const response = await fetch(url, body)
      delegateDeleteButtonState("pending")
      const data = await response
      return data
    } catch (error) {
      setError(error.message)
      return error
    }

  }

  const delegateDeleteButtonState = (stateToSet) => {
    const buttonStates = {
      "initial": deleteButtonData,
      "pending": deleteButtonPendingData,
      "done": deleteButtonDoneData
    }
    setDeleteButtonState(buttonStates[stateToSet])
  }  

  const handleDeleteClaimResponse = (res) =>{
    if(res.status){
      switch(res.status){
        case 204:
          delegateDeleteButtonState("done")
          return res
        case 400:
          setError("Offer was not found. Refresh the page and try again.")
          delegateDeleteButtonState("initial")
        case 401:
          setError('Sign in again to continue.')
          delegateDeleteButtonState("initial")
        default:
          setError(res.message)
          delegateDeleteButtonState("initial")
      }
    } else {
      delegateDeleteButtonState("initial")
      return res
    }
  }  

  // RENDER
  if(show){
    return(
      <div onClick={logSuggestionData} className="offer">
        <h5 className="offer-title">{offer.title}</h5>
        <p className="offer-description">{offer.description}</p>
        <div className="tag-container">
          {tags.map((tag, index) => (
            <span key={tag.slug} className="tag">{tag.name}</span> 
          ))}      
        </div>

        { actionSet === 'claim' && 
          <div>
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
        }

        { actionSet === 'unclaim' && 
          <div>
            <hr/>
            <button 
              data-offer-id={offer.id} 
              onClick={deleteClickHandler} 
              className="claim-button delete-button"
              disabled={deleteButtonState.disabled}
            >
              {deleteButtonState.text}
            </button>
          </div>
        }      

      </div>
    )    
  }
}

export default Offer;