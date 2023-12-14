import PropTypes from 'prop-types';
import React, { useState } from 'react';

const DiscoverForm = ({tags}) => {
  const [activeTags, setActiveTags] = useState(tags)

  const handleSubmit = (event) =>{
    event.preventDefault()
  }

  const handleTagClick = (event) =>{
    event.preventDefault()
    
  }

  return(
    <form onSubmit={handleSubmit} className="discover-form">
      <label htmlFor="discover_form">Search</label>
      <input type="text" id="discover_form"/>
      {
        tags.map((tag, index) => (
          <button onClick={handleTagClick} id={`tag-${tag.id}`} className="tag-button" key={index}>{tag.name}</button>
        ))
      }
    </form>
  )
}

export default DiscoverForm;