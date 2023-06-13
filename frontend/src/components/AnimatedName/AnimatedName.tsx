import type React from 'react'

import './AnimatedName.css'

const Animation: React.FC = () => {
  return (
    <div className='container'>
      <div className='box'>
        <div className='title'>
          <span className='block'></span>
          <h1>
            Word Wise<span></span>
          </h1>
        </div>

        <div className='role'>
          <div className='block'></div>
          <p className='text1'>English &zwnj;</p>
          <p className='text2'>vibes</p>
        </div>
      </div>
    </div>
  )
}

export default Animation
