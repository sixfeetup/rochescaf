import Link from 'next/link'

const Footer = () => {
  return (
    <footer className='bg-gray-800 py-8 text-white'>
      <div className='container mx-auto px-4'>
        <div className='flex items-center justify-between'>
          <div>
            <h3 className='text-lg font-bold'>{'Roche Scaf'}</h3>
            <p className='text-sm'>
              &copy; {new Date().getFullYear()} {'Roche Scaf'}. All rights reserved.
            </p>
          </div>
          <div className='space-x-4'>
            <Link href='/'>Home</Link>
            <Link href='/about'>About</Link>
          </div>
        </div>
      </div>
    </footer>
  )
}

export default Footer
