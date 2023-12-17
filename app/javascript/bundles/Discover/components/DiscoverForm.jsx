import PropTypes from 'prop-types';
import React, { useState, useContext } from 'react';
import Select from 'react-select';
import { DiscoverContext } from './DiscoverContext'

const DiscoverForm = ({setActiveOffers, setError}) => {
  const suggestButtonData = {text: "Suggest!", disabled: false}
  const suggestButtonDisabledData = {text: "Suggesting...", disabled: true}
  const [suggestButtonState, setSuggestButtonState] = useState(suggestButtonData)

  const offersData = useContext(DiscoverContext)
  const [selectedOption, setSelectedOption] = useState([]);

  const player = offersData.player
  const tags = offersData.tags
  const offers = offersData.offers

  const formOptions = tags.map((tag)=>(
    {value: tag.id, label: tag.name}
  ))

  const handleSubmit = (event) =>{
    event.preventDefault()
  }

  // SUGGESTIONS
  const handleSuggestionResponse = (res) =>{
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
      if(res.length > 0){
        setActiveOffers(res)
      } else {
        setError("No offers were found that could be suggested")
      }
      
      setSuggestButtonState(suggestButtonData)
      return res
    }    
  }

  const suggestionClickHandler = (event) =>{
    event.preventDefault()
    const response = getPlayerOfferSuggestions()
    response.then((res) => (
      handleSuggestionResponse(res)
    ))

  }

  const getPlayerOfferSuggestions = async () =>{
    const location = `${window.location.protocol}//${window.location.host}`
    const url = `${location}/api/v1/suggestions/${player.id}`
    const csrf = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
    const body = {
      method: "GET",
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrf,
      }
    }
    try{
      setSuggestButtonState(suggestButtonDisabledData)
      const response = await fetch(url, body)
      const data = await response.json();
      return data
    } catch (error) {
      setError(error.message)
      return error
    }    

  }

  // TAG FILTERING
  const handleTagFilterChange = (event) => {
    const newOffersData = []
    const selectedTags = []

    selectedOption.forEach((option)=>(
      selectedTags.push(option.value)
    ))

    for (let i = 0; i < offers.length; i++) {
      let offer = offers[i]
      let presentTags = offer.tags.map(tag => tag.id)
      let hasTag = selectedTags.every(rt => presentTags.includes(rt))
      if(hasTag){
        offer.show = true
      } else {
        offer.show = false
      }
      newOffersData.push(offer)
    }
    setActiveOffers(newOffersData)
  }

  const resetOfferShow = ()=>{
    const resetOffers = offers
    resetOffers.forEach((offer)=>(
      offer.show = true   
    ))
    setActiveOffers(resetOffers)
  }

  const handleFilterClick = (event) =>{
    event.preventDefault()
    if(selectedOption.length){
      handleTagFilterChange()  
    } else {
      resetOfferShow()
    } 
  }  

  return(
    <form onSubmit={handleSubmit} className="discover-form">
      <p>The more you claim, the better the suggestions!</p>
      <button 
        onClick={suggestionClickHandler} 
        className="suggest-button"
        disabled={suggestButtonState.disabled}
      >{suggestButtonState.text}</button>
      <hr/>
      <Select
        defaultValue={selectedOption}
        onChange={setSelectedOption}
        options={formOptions}
        isMulti={true}
        placeholder={"Filter by Tag"}
        className="filter-tags"
      />
      <button className="filter-button" onClick={handleFilterClick}>Filter</button>
    </form>
  )
}

export default DiscoverForm;