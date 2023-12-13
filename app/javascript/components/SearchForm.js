import React from "react"
import PropTypes from "prop-types"

const SearchForm = (props) => {
  return (
    <React.Fragment>
      First Offer: {props.offers[1].name}
    </React.Fragment>
  )
}

SearchForm.propTypes = {
  offers: PropTypes.array
};

export default SearchForm