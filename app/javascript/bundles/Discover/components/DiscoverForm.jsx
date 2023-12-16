import PropTypes from 'prop-types';
import React, { useState, useContext } from 'react';
import Select from 'react-select';
import { DiscoverContext } from './DiscoverContext'

const DiscoverForm = ({setActiveOffers}) => {
  const offersData = useContext(DiscoverContext)
  const [selectedOption, setSelectedOption] = useState([]);

  const tags = offersData.tags
  const offers = offersData.offers

  const formOptions = tags.map((tag)=>(
    {value: tag.id, label: tag.name}
  ))

  const handleSubmit = (event) =>{
    event.preventDefault()
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

  function refreshPage() {
    window.location.reload(false);
  }  

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

  return(
    <form onSubmit={handleSubmit} className="discover-form">
      <p>The more you claim, the better the suggestions!</p>
      <button onClick={refreshPage} className="suggest-button">Suggest!</button>
      <hr/>
      {/*<label htmlFor="discover_form">Search</label>*/}
      {/*<input type="text" id="discover_form"/>*/}
      <Select
        defaultValue={selectedOption}
        onChange={setSelectedOption}
        options={formOptions}
        isMulti={true}
        placeholder={"Filter by Tag"}
      />
      <button className="filter-button" onClick={handleFilterClick}>Filter</button>
    </form>
  )
}

export default DiscoverForm;