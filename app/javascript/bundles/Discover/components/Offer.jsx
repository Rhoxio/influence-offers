import PropTypes from 'prop-types';
import React, { useState } from 'react';

const Offer = ({offer, tags, show}) =>{
  // console.log(tags)

  const claimClickHandler = (event) =>{
    event.preventDefault()
    // console.log(event)
    event.target.disabled = true
    event.target.innerHTML = "Claimed!"
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
        <button data-offer-id={offer.id} onClick={claimClickHandler} className="claim-button">Claim</button>

      </div>
    )    
  }


}

export default Offer;